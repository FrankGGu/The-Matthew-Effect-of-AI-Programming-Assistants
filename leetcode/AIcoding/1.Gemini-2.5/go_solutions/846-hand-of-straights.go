import (
	"sort"
)

func isNStraightHand(hand []int, groupSize int) bool {
	n := len(hand)

	if n%groupSize != 0 {
		return false
	}

	// Sort the hand to process cards in increasing order
	sort.Ints(hand)

	// Create a frequency map for the cards
	freq := make(map[int]int)
	for _, card := range hand {
		freq[card]++
	}

	// Iterate through the sorted hand
	for _, card := range hand {
		// If this card has already been used in a straight, skip it
		if freq[card] == 0 {
			continue
		}

		// Try to form a straight starting with 'card'
		for i := 0; i < groupSize; i++ {
			currentCard := card + i
			// If any card in the potential straight is not available, return false
			if freq[currentCard] == 0 {
				return false
			}
			// Decrement the count for the current card in the straight
			freq[currentCard]--
		}
	}

	// If all cards were successfully grouped into straights
	return true
}