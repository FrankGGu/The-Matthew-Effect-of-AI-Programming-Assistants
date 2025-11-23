func guardCastle(grid []string) int {
	m, n := len(grid), len(grid[0])
	guards := make([][]int, 0)
	walls := make([][]int, 0)

	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] == 'G' {
				guards = append(guards, []int{i, j})
			} else if grid[i][j] == 'W' {
				walls = append(walls, []int{i, j})
			}
		}
	}

	count := 0
	for i := 0; i < m; i++ {
		for j := 0; j < n; j++ {
			if grid[i][j] == '0' {
				blocked := false
				for _, wall := range walls {
					if (wall[0] == i && wall[1] < j) || (wall[0] == i && wall[1] > j) || (wall[1] == j && wall[0] < i) || (wall[1] == j && wall[0] > i) {

					} else {
						continue
					}

					if wall[0] == i {
						block := true
						for k := 0; k < len(guards); k++{
							if guards[k][0] == i {
								if (guards[k][1] < j && guards[k][1] > wall[1]) || (guards[k][1] > j && guards[k][1] < wall[1]) {
									block = false
								}
							}
						}
						if block {
							blocked = true
							break
						}

					} else if wall[1] == j {
						block := true
						for k := 0; k < len(guards); k++{
							if guards[k][1] == j {
								if (guards[k][0] < i && guards[k][0] > wall[0]) || (guards[k][0] > i && guards[k][0] < wall[0]) {
									block = false
								}
							}
						}
						if block {
							blocked = true
							break
						}
					}
				}

				if !blocked {

					visible := false
					for _, guard := range guards {
						if guard[0] == i {
							wallBetween := false
							if guard[1] < j {
								for _, wall := range walls {
									if wall[0] == i && wall[1] > guard[1] && wall[1] < j {
										wallBetween = true
										break
									}
								}
							} else {
								for _, wall := range walls {
									if wall[0] == i && wall[1] < guard[1] && wall[1] > j {
										wallBetween = true
										break
									}
								}
							}
							if !wallBetween {
								visible = true
								break
							}
						} else if guard[1] == j {
							wallBetween := false
							if guard[0] < i {
								for _, wall := range walls {
									if wall[1] == j && wall[0] > guard[0] && wall[0] < i {
										wallBetween = true
										break
									}
								}
							} else {
								for _, wall := range walls {
									if wall[1] == j && wall[0] < guard[0] && wall[0] > i {
										wallBetween = true
										break
									}
								}
							}
							if !wallBetween {
								visible = true
								break
							}
						}
					}

					if !visible {
						count++
					}
				}
			}
		}
	}

	return count
}