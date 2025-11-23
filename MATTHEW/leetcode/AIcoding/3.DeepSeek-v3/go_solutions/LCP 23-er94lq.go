func isMagic(target []int) bool {
    n := len(target)
    if n == 0 {
        return true
    }
    arr := make([]int, n)
    for i := 0; i < n; i++ {
        arr[i] = i + 1
    }
    k := 0
    for {
        tmp := make([]int, 0)
        for i := 1; i < len(arr); i += 2 {
            tmp = append(tmp, arr[i])
        }
        for i := 0; i < len(arr); i += 2 {
            tmp = append(tmp, arr[i])
        }
        arr = tmp
        cnt := 0
        for i := 0; i < len(arr) && i < len(target); i++ {
            if arr[i] == target[i] {
                cnt++
            } else {
                break
            }
        }
        if cnt > k {
            k = cnt
        } else {
            break
        }
    }
    if k == 0 {
        return false
    }
    for k > 0 {
        tmp := make([]int, 0)
        for i := 1; i < len(arr); i += 2 {
            tmp = append(tmp, arr[i])
        }
        for i := 0; i < len(arr); i += 2 {
            tmp = append(tmp, arr[i])
        }
        arr = tmp
        match := true
        for i := 0; i < k && i < len(target); i++ {
            if arr[i] != target[i] {
                match = false
                break
            }
        }
        if match {
            if len(arr) == len(target) {
                for i := 0; i < len(arr); i++ {
                    if arr[i] != target[i] {
                        match = false
                        break
                    }
                }
                if match {
                    return true
                }
            }
            target = target[k:]
            arr = arr[k:]
            k = 0
            for {
                tmp := make([]int, 0)
                for i := 1; i < len(arr); i += 2 {
                    tmp = append(tmp, arr[i])
                }
                for i := 0; i < len(arr); i += 2 {
                    tmp = append(tmp, arr[i])
                }
                arr = tmp
                cnt := 0
                for i := 0; i < len(arr) && i < len(target); i++ {
                    if arr[i] == target[i] {
                        cnt++
                    } else {
                        break
                    }
                }
                if cnt > k {
                    k = cnt
                } else {
                    break
                }
            }
        } else {
            k--
        }
    }
    return false
}