package main

import (
	"container/list"
)

type QueueItem struct {
	gene  string
	steps int
}

func minMutation(startGene string, endGene string, bank []string) int {
	bankSet := make(map[string]bool)
	for _, gene := range bank {
		bankSet[gene] = true
	}

	if !bankSet[endGene] {
		return -1
	}

	chars := []byte{'A', 'C', 'G', 'T'}

	queue := list.New()
	queue.PushBack(QueueItem{startGene, 0})

	visited := make(map[string]bool)
	visited[startGene] = true

	for queue.Len() > 0 {
		element := queue.Remove(queue.Front()).(QueueItem)
		currentGene := element.gene
		currentSteps := element.steps

		if currentGene == endGene {
			return currentSteps
		}

		geneBytes := []byte(currentGene)
		for i := 0; i < len(geneBytes); i++ {
			originalChar := geneBytes[i]
			for _, char := range chars {
				if char == originalChar {
					continue
				}

				geneBytes[i] = char
				nextGene := string(geneBytes)

				if bankSet[nextGene] && !visited[nextGene] {
					visited[nextGene] = true
					queue.PushBack(QueueItem{nextGene, currentSteps + 1})
				}
			}
			geneBytes[i] = originalChar
		}
	}

	return -1
}