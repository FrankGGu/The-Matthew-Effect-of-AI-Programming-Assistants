func canEvolve(biomes []string) bool {
    cnt := make(map[string]int)
    for _, biome := range biomes {
        cnt[biome]++
    }

    for _, v := range cnt {
        if v > 1 {
            return false
        }
    }

    return true
}