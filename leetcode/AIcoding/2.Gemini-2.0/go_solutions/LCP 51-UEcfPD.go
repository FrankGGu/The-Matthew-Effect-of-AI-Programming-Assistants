func perfectMenu(materials []int, cookbooks [][]int, attribute [][]int, limit int) int {
	n := len(cookbooks)
	ans := -1

	var dfs func(int, []int, int)
	dfs = func(index int, curMaterials []int, curSatisfaction int) {
		if index == n {
			if curSatisfaction >= ans {
				ans = curSatisfaction
			}
			return
		}

		dfs(index+1, curMaterials, curSatisfaction)

		canCook := true
		for i := 0; i < len(materials); i++ {
			if curMaterials[i]+cookbooks[index][i] > materials[i] {
				canCook = false
				break
			}
		}

		if canCook {
			newMaterials := make([]int, len(materials))
			for i := 0; i < len(materials); i++ {
				newMaterials[i] = curMaterials[i] + cookbooks[index][i]
			}

			newSatisfaction := curSatisfaction + attribute[index][0]
			newCalories := attribute[index][1]

			if newCalories <= limit {
				dfs(index+1, newMaterials, newSatisfaction)
			}
		}
	}

	initialMaterials := make([]int, len(materials))
	dfs(0, initialMaterials, 0)

	return ans
}