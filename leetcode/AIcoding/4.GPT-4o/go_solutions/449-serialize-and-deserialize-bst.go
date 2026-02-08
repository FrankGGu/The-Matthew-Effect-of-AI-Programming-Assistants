package main

import (
	"strconv"
	"strings"
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
	var builder strings.Builder
	var serializeHelper func(node *TreeNode)
	serializeHelper = func(node *TreeNode) {
		if node == nil {
			builder.WriteString("null,")
			return
		}
		builder.WriteString(strconv.Itoa(node.Val) + ",")
		serializeHelper(node.Left)
		serializeHelper(node.Right)
	}
	serializeHelper(root)
	return builder.String()[:builder.Len()-1]
}

func (this *Codec) deserialize(data string) *TreeNode {
	nodes := strings.Split(data, ",")
	index := 0
	var deserializeHelper func() *TreeNode
	deserializeHelper = func() *TreeNode {
		if index >= len(nodes) || nodes[index] == "null" {
			index++
			return nil
		}
		val, _ := strconv.Atoi(nodes[index])
		index++
		node := &TreeNode{Val: val}
		node.Left = deserializeHelper()
		node.Right = deserializeHelper()
		return node
	}
	return deserializeHelper()
}