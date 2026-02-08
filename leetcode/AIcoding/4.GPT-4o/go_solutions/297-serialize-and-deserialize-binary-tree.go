package main

import (
	"strings"
	"strconv"
	"github.com/google/go-cmp/cmp"
)

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

type Codec struct{}

func Constructor() Codec {
	return Codec{}
}

func (this *Codec) serialize(root *TreeNode) string {
	if root == nil {
		return "null"
	}
	return strconv.Itoa(root.Val) + "," + this.serialize(root.Left) + "," + this.serialize(root.Right)
}

func (this *Codec) deserialize(data string) *TreeNode {
	nodes := strings.Split(data, ",")
	var buildTree func() *TreeNode
	i := 0
	buildTree = func() *TreeNode {
		if nodes[i] == "null" {
			i++
			return nil
		}
		val, _ := strconv.Atoi(nodes[i])
		i++
		node := &TreeNode{Val: val}
		node.Left = buildTree()
		node.Right = buildTree()
		return node
	}
	return buildTree()
}