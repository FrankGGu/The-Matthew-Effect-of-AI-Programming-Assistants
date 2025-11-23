package main

import (
	"sort"
	"strings"
)

func braceExpansionII(expression string) []string {
	return sortedUnique(expand(expression))
}

func expand(expression string) []string {
	parts := splitExpression(expression)
	result := []string{""}

	for _, part := range parts {
		if part == "" {
			continue
		}
		if part[0] == '{' {
			choices := getChoices(part[1 : len(part)-1])
			newResult := []string{}
			for _, res := range result {
				for _, choice := range choices {
					newResult = append(newResult, res+choice)
				}
			}
			result = newResult
		} else {
			for i := range result {
				result[i] += part
			}
		}
	}
	return result
}

func splitExpression(expression string) []string {
	var parts []string
	count := 0
	start := 0
	for i, ch := range expression {
		if ch == '{' {
			if count == 0 {
				parts = append(parts, expression[start:i])
				start = i
			}
			count++
		} else if ch == '}' {
			count--
			if count == 0 {
				parts = append(parts, expression[start:i+1])
				start = i + 1
			}
		}
	}
	if start < len(expression) {
		parts = append(parts, expression[start:])
	}
	return parts
}

func getChoices(part string) []string {
	subParts := strings.Split(part, ",")
	sort.Strings(subParts)
	return subParts
}

func sortedUnique(arr []string) []string {
	sort.Strings(arr)
	unique := []string{}
	for i, str := range arr {
		if i == 0 || str != arr[i-1] {
			unique = append(unique, str)
		}
	}
	return unique
}