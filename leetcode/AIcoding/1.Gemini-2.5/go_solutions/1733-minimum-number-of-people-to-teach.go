import (
	"math"
)

func minimumTeachings(n int, languages [][]int, friendships [][]int) int {
	m := len(languages)

	personSpeaks := make([]map[int]bool, m)
	for i := 0; i < m; i++ {
		personSpeaks[i] = make(map[int]bool)
		for _, lang := range languages[i] {
			personSpeaks[i][lang] = true
		}
	}

	problematicPeople := make(map[int]bool) 

	for _, friendship := range friendships {
		p1 := friendship[0] - 1 
		p2 := friendship[1] - 1 

		canCommunicate := false
		for lang := range personSpeaks[p1] {
			if personSpeaks[p2][lang] {
				canCommunicate = true
				break
			}
		}

		if !canCommunicate {
			problematicPeople[p1] = true
			problematicPeople[p2] = true
		}
	}

	if len(problematicPeople) == 0 {
		return 0
	}

	minTaught := math.MaxInt32

	for teachLang := 1; teachLang <= n; teachLang++ { 
		currentTaught := 0
		for personID := range problematicPeople { 
			if !personSpeaks[personID][teachLang] {
				currentTaught++
			}
		}

		if currentTaught < minTaught {
			minTaught = currentTaught
		}
	}

	return minTaught
}