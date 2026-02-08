package main

import (
	"fmt"
	"sort"
)

func deleteDuplicateFolders(paths []string) []string {
	folderMap := make(map[string]int)
	for _, path := range paths {
		folderMap[path]++
	}

	var uniquePaths []string
	for path := range folderMap {
		uniquePaths = append(uniquePaths, path)
	}

	sort.Strings(uniquePaths)

	result := []string{}
	seen := make(map[string]bool)
	for _, path := range uniquePaths {
		parts := splitPath(path)
		if !isDuplicate(parts, seen) {
			result = append(result, path)
			markSeen(parts, seen)
		}
	}

	return result
}

func splitPath(path string) []string {
	parts := []string{}
	current := ""
	for _, char := range path {
		if char == '/' {
			parts = append(parts, current)
			current = ""
		} else {
			current += string(char)
		}
	}
	parts = append(parts, current)
	return parts
}

func isDuplicate(parts []string, seen map[string]bool) bool {
	current := ""
	for _, part := range parts {
		current += "/" + part
		if seen[current] {
			return true
		}
	}
	return false
}

func markSeen(parts []string, seen map[string]bool) {
	current := ""
	for _, part := range parts {
		current += "/" + part
		seen[current] = true
	}
}

func main() {
	paths := []string{"/a", "/a/b", "/c", "/a/b/c", "/c/d"}
	result := deleteDuplicateFolders(paths)
	fmt.Println(result)
}