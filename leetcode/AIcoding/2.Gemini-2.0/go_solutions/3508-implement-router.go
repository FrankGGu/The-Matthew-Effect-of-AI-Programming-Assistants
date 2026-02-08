import (
	"net/http"
	"strings"
)

type node struct {
	pattern  string
	handler  http.HandlerFunc
	children []*node
	isWild   bool
}

type Router struct {
	root *node
}

func NewRouter() *Router {
	return &Router{root: &node{}}
}

func (r *Router) AddRoute(pattern string, handler http.HandlerFunc) {
	parts := parsePattern(pattern)
	curr := r.root

	for _, part := range parts {
		child := curr.matchChild(part)
		if child == nil {
			child = &node{pattern: part, isWild: strings.HasPrefix(part, ":") || strings.HasPrefix(part, "*")}
			curr.children = append(curr.children, child)
		}
		curr = child
	}

	curr.handler = handler
}

func (r *Router) FindRoute(path string) (http.HandlerFunc, map[string]string) {
	parts := parsePattern(path)
	curr := r.root
	params := make(map[string]string)

	for _, part := range parts {
		child := curr.matchChild(part)
		if child == nil {
			return nil, nil
		}
		if child.isWild {
			if strings.HasPrefix(child.pattern, ":") {
				params[child.pattern[1:]] = part
			} else if strings.HasPrefix(child.pattern, "*") {
				params[child.pattern[1:]] = strings.Join(parts[len(parts)-1:], "/")
				break
			}

		}
		curr = child
	}

	if curr.handler == nil {
		return nil, nil
	}

	return curr.handler, params
}

func (n *node) matchChild(part string) *node {
	for _, child := range n.children {
		if child.pattern == part || child.isWild {
			return child
		}
	}
	return nil
}

func parsePattern(pattern string) []string {
	vs := strings.Split(pattern, "/")
	parts := make([]string, 0)
	for _, item := range vs {
		if item != "" {
			parts = append(parts, item)
			if strings.HasPrefix(item, "*") {
				break
			}
		}
	}
	return parts
}