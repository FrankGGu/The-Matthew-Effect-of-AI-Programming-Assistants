func dividePlayers(skill []int) int64 {
    n := len(skill)
    totalSkill := 0
    for _, s := range skill {
        totalSkill += s
    }
    if totalSkill%n != 0 {
        return 0
    }
    target := totalSkill / (n / 2)
    skillMap := make(map[int]int)
    for _, s := range skill {
        skillMap[s]++
    }
    var result int64
    for _, s := range skill {
        if skillMap[s] > 0 {
            partner := target - s
            if skillMap[partner] > 0 {
                if partner == s && skillMap[s] < 2 {
                    return 0
                }
                result += int64(s * partner)
                skillMap[s]--
                skillMap[partner]--
            }
        }
    }
    return result
}