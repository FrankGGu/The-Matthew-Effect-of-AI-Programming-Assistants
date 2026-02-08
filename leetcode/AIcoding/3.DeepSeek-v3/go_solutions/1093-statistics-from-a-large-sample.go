func sampleStats(count []int) []float64 {
    min := -1
    max := 0
    sum := 0
    total := 0
    mode := 0
    maxCount := 0

    for i, cnt := range count {
        if cnt > 0 {
            if min == -1 {
                min = i
            }
            max = i
            sum += i * cnt
            total += cnt
            if cnt > maxCount {
                maxCount = cnt
                mode = i
            }
        }
    }

    mean := float64(sum) / float64(total)

    median := 0.0
    half := total / 2
    if total % 2 == 1 {
        cnt := 0
        for i, c := range count {
            cnt += c
            if cnt > half {
                median = float64(i)
                break
            }
        }
    } else {
        cnt := 0
        left := -1
        right := -1
        for i, c := range count {
            cnt += c
            if left == -1 && cnt >= half {
                left = i
            }
            if right == -1 && cnt >= half + 1 {
                right = i
                break
            }
        }
        median = float64(left + right) / 2.0
    }

    return []float64{float64(min), float64(max), mean, median, float64(mode)}
}