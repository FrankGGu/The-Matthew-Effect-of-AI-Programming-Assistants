import "math"

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func maxPoints(enemies []int, armor int, attack int) int {
	n := len(enemies)
	totalDamage := 0
	maxDamage := 0
	for i := 0; i < n; i++ {
		totalDamage += enemies[i]
		maxDamage = max(maxDamage, enemies[i])
	}

	if armor >= maxDamage {
		return totalDamage - maxDamage + attack
	} else {
		return totalDamage - armor
	}
}