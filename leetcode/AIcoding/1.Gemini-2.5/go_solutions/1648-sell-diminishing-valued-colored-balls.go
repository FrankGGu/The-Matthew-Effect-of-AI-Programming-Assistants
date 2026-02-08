package main

import (
	"sort"
)

func sumSeries(start, end int64) int64 {
	count := start - end + 1
	if count <= 0 { // No terms or invalid range
		return 0
	}
	return (start + end) * count / 2
}

func maxProfit(inventory []int, orders int) int {
	// Sort the inventory in descending order to process highest value balls first.
	sort.Slice(inventory, func(i, j int) bool {
		return inventory[i] > inventory[j]
	})

	var totalProfit int64
	mod := int64(1e9 + 7) // Modulo constant

	currentOrders := int64(orders)

	i := 0 // Index for the sorted inventory
	numColorsAtCurrentLevel := int64(0) // Number of colors that currently have the same highest value

	// Iterate while there are orders to fulfill
	for currentOrders > 0 {
		numColorsAtCurrentLevel++ // Add the current pile to the group of highest value piles

		currentVal := int64(inventory[i]) // The current highest value of balls

		var nextVal int64
		// Determine the value of the next distinct pile, or 0 if this is the last pile
		if i+1 < len(inventory) {
			nextVal = int64(inventory[i+1])
		} else {
			nextVal = 0 // If no next pile, assume value drops to 0
		}

		// Calculate the difference between the current highest value and the next highest value.
		// This is the number of balls we can sell from each of the 'numColorsAtCurrentLevel' piles
		// before their value drops to 'nextVal'.
		diff := currentVal - nextVal

		// Calculate the total number of balls we can sell from this layer (all piles at currentVal)
		// until their value reaches 'nextVal'.
		sellableInThisLayer := diff * numColorsAtCurrentLevel

		if sellableInThisLayer <= currentOrders {
			// If we have enough orders to sell all balls in this layer:
			// Calculate the profit from selling balls from 'currentVal' down to 'nextVal + 1'
			// for each of the 'numColorsAtCurrentLevel' piles.
			sumThisLayerPerPile := sumSeries(currentVal, nextVal + 1)

			totalProfit = (totalProfit + sumThisLayerPerPile * numColorsAtCurrentLevel) % mod
			currentOrders -= sellableInThisLayer
			i++ // Move to the next distinct value in the inventory

			// If all initial inventory items have been processed, and orders still remain,
			// it means we are trying to sell balls whose value has dropped to 0.
			// Selling 0-value balls adds 0 to profit, so we can stop.
			if i == len(inventory) {
				break
			}
		} else {
			// If we don't have enough orders to sell all balls in this layer:
			// We need to fulfill the remaining 'currentOrders' by selling balls from the
			// 'numColorsAtCurrentLevel' piles.

			// Calculate how many balls each of these piles will contribute fully.
			countEach := currentOrders / numColorsAtCurrentLevel
			// Calculate how many piles will contribute one extra ball.
			remainder := currentOrders % numColorsAtCurrentLevel

			// Add profit from 'countEach' balls sold from each of the 'numColorsAtCurrentLevel' piles.
			// These balls range from 'currentVal' down to 'currentVal - countEach + 1'.
			sumValEachPile := sumSeries(currentVal, currentVal - countEach + 1)
			totalProfit = (totalProfit + sumValEachPile * numColorsAtCurrentLevel) % mod

			// Add profit from the 'remainder' piles that sell one additional ball.
			// The value of this additional ball is 'currentVal - countEach'.
			if remainder > 0 {
				valForRemainder := currentVal - countEach
				totalProfit = (totalProfit + valForRemainder * remainder) % mod
			}

			currentOrders = 0 // All orders fulfilled
			break
		}
	}

	return int(totalProfit)
}