package main

import (
	"fmt"
	"strings"
)

func findDuplicate(paths []string) [][]string {
	fileMap := make(map[string][]string)

	for _, path := range paths {
		parts := strings.Split(path, " ")
		root := parts[0]
		for _, file := range parts[1:] {
			// Find the file name and content
			idx := strings.Index(file, "(")
			name := file[:idx]
			content := file[idx:]
			fullPath := root + "/" + name
			fileMap[content] = append(fileMap[content], fullPath)
		}
	}

	var result [][]string
	for _, files := range fileMap {
		if len(files) > 1 {
			result = append(result, files)
		}
	}
	return result
}