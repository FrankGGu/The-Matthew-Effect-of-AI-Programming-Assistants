package main

import (
	"sort"
)

type Person struct {
	Name   string
	Height int
}

func sortPeople(names []string, heights []int) []string {
	people := make([]Person, len(names))
	for i := 0; i < len(names); i++ {
		people[i] = Person{Name: names[i], Height: heights[i]}
	}

	sort.Slice(people, func(i, j int) bool {
		return people[i].Height > people[j].Height
	})

	sortedNames := make([]string, len(names))
	for i := 0; i < len(people); i++ {
		sortedNames[i] = people[i].Name
	}

	return sortedNames
}