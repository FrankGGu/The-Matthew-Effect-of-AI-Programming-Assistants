package main

import (
	"strings"
)

type Node struct {
	segment    string
	children   map[string]*Node
	paramChild *Node
	anyChild   *Node
	handler    interface{}
	paramName  string
}

func newRootNode() *Node {
	return &Node{
		segment:  "/",
		children: make(map[string]*Node),
	}
}

func newNode(segment string) *Node {
	return &Node{
		segment:  segment,
		children: make(map[string]*Node),
	}
}

type Router struct {
	root *Node
}

func NewRouter() *Router {
	return &Router{
		root: newRootNode(),
	}
}

func (r *Router) AddRoute(path string, handler interface{}) {
	curr := r.root
	segments := r.splitPath(path)

	for _, seg := range segments {
		if strings.HasPrefix(seg, ":") {
			paramName := seg[1:]
			if curr.paramChild == nil {
				curr.paramChild = newNode(seg)
			}
			curr.paramChild.paramName = paramName
			curr = curr.paramChild
		} else if seg == "*" {
			if curr.anyChild == nil {
				curr.anyChild = newNode(seg)
			}
			curr = curr.anyChild
		} else {
			if curr.children[seg] == nil {
				curr.children[seg] = newNode(seg)
			}
			curr = curr.children[seg]
		}
	}
	curr.handler = handler
}

func (r *Router) Match(path string) (interface{}, map[string]string) {
	params := make(map[string]string)
	segments := r.splitPath(path)

	handler, finalParams, ok := r.matchRecursive(r.root, segments, 0, params)
	if !ok {
		return nil, nil
	}
	return handler, finalParams
}

func (r *Router) matchRecursive(node *Node, pathSegments []string, segIndex int, currentParams map[string]string) (interface{}, map[string]string, bool) {
	if segIndex == len(pathSegments) {
		if node.handler != nil {
			return node.handler, currentParams, true
		}
		return nil, nil, false
	}

	pathSeg := pathSegments[segIndex]
	nextSegIndex := segIndex + 1

	if child, ok := node.children[pathSeg]; ok {
		if handler, params, found := r.matchRecursive(child, pathSegments, nextSegIndex, currentParams); found {
			return handler, params, true
		}
	}

	if node.paramChild != nil {
		newParams := make(map[string]string)
		for k, v := range currentParams {
			newParams[k] = v
		}
		newParams[node.paramChild.paramName] = pathSeg
		if handler, params, found := r.matchRecursive(node.paramChild, pathSegments, nextSegIndex, newParams); found {
			return handler, params, true
		}
	}

	if node.anyChild != nil {
		if handler, params, found := r.matchRecursive(node.anyChild, pathSegments, nextSegIndex, currentParams); found {
			return handler, params, true
		}
	}

	return nil, nil, false
}

func (r *Router) splitPath(path string) []string {
	cleanedPath := strings.Trim(path, "/")
	if cleanedPath == "" {
		return []string{}
	}
	segments := strings.Split(cleanedPath, "/")

	filteredSegments := make([]string, 0, len(segments))
	for _, seg := range segments {
		if seg != "" {
			filteredSegments = append(filteredSegments, seg)
		}
	}
	return filteredSegments
}