package main

import (
	"fmt"
)

func findAllRecipes(recipes []string, ingredients [][]string, supplies []string) []string {
	supplySet := make(map[string]bool)
	for _, supply := range supplies {
		supplySet[supply] = true
	}

	recipeMap := make(map[string][]string)
	for i, recipe := range recipes {
		recipeMap[recipe] = ingredients[i]
	}

	var result []string
	visited := make(map[string]bool)
	var dfs func(string) bool
	dfs = func(recipe string) bool {
		if visited[recipe] {
			return false
		}
		if _, ok := supplySet[recipe]; ok {
			return true
		}
		if ingrs, ok := recipeMap[recipe]; ok {
			for _, ingr := range ingrs {
				if !dfs(ingr) {
					return false
				}
			}
		}
		visited[recipe] = true
		result = append(result, recipe)
		return true
	}

	for _, recipe := range recipes {
		dfs(recipe)
	}

	return result
}

func main() {
	recipes := []string{"bread", "sandwich"}
	ingredients := [][]string{{"yeast", "flour"}, {"bread"}}
	supplies := []string{"yeast", "flour", "meat"}
	fmt.Println(findAllRecipes(recipes, ingredients, supplies))
}