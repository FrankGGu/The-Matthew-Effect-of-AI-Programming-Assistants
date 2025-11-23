package main

import (
	"container/heap"
	"sort"
)

type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

type Item struct {
	x, y, val int
}

type ItemHeap []Item

func (h ItemHeap) Len() int           { return len(h) }
func (h ItemHeap) Less(i, j int) bool { return h[i].x < h[j].x || (h[i].x == h[j].x && h[i].y < h[j].y) || (h[i].x == h[j].x && h[i].y == h[j].y && h[i].val < h[j].val) }
func (h ItemHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *ItemHeap) Push(x interface{}) {
	*h = append(*h, x.(Item))
}

func (h *ItemHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}

func verticalTraversal(root *TreeNode) [][]int {
	if root == nil {
		return [][]int{}
	}
	var items ItemHeap
	var dfs func(node *TreeNode, x, y int)
	dfs = func(node *TreeNode, x, y int) {
		if node == nil {
			return
		}
		items = append(items, Item{x, y, node.Val})
		dfs(node.Left, x-1, y+1)
		dfs(node.Right, x+1, y+1)
	}
	dfs(root, 0, 0)
	heap.Init(&items)
	sort.Slice(items, func(i, j int) bool {
		if items[i].x == items[j].x {
			if items[i].y == items[j].y {
				return items[i].val < items[j].val
			}
			return items[i].y < items[j].y
		}
		return items[i].x < items[j].x
	})
	result := [][]int{}
	col := []int{}
	lastX := items[0].x
	for _, item := range items {
		if item.x != lastX {
			result = append(result, col)
			col = []int{}
			lastX = item.x
		}
		col = append(col, item.val)
	}
	result = append(result, col)
	return result
}