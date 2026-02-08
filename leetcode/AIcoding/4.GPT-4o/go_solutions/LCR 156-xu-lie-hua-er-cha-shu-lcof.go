package main

import (
	"bytes"
	"strconv"
	"strings"
)

// Definition for a binary tree node.
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
	var buf bytes.Buffer
	var serializeHelper func(node *TreeNode)
	serializeHelper = func(node *TreeNode) {
		if node == nil {
			buf.WriteString("#,")
			return
		}
		buf.WriteString(strconv.Itoa(node.Val) + ",")
		serializeHelper(node.Left)
		serializeHelper(node.Right)
	}
	serializeHelper(root)
	return buf.String()
}

func (this *Codec) deserialize(data string) *TreeNode {
	nodes := strings.Split(data, ",")
	var deserializeHelper func() *TreeNode
	i := 0
	deserializeHelper = func() *TreeNode {
		if nodes[i] == "#" {
			i++
			return nil
		}
		val, _ := strconv.Atoi(nodes[i])
		i++
		node := &TreeNode{Val: val}
		node.Left = deserializeHelper()
		node.Right = deserializeHelper()
		return node
	}
	return deserializeHelper()
}