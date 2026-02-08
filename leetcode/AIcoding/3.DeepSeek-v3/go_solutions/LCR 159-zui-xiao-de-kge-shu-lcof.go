func inventoryManagement(stock []int, cnt int) []int {
    if cnt >= len(stock) {
        return stock
    }
    quickSelect(stock, 0, len(stock)-1, cnt)
    return stock[:cnt]
}

func quickSelect(arr []int, left, right, k int) {
    if left >= right {
        return
    }
    pivot := partition(arr, left, right)
    if pivot == k {
        return
    } else if pivot < k {
        quickSelect(arr, pivot+1, right, k)
    } else {
        quickSelect(arr, left, pivot-1, k)
    }
}

func partition(arr []int, left, right int) int {
    pivot := arr[left]
    i, j := left, right
    for i < j {
        for i < j && arr[j] >= pivot {
            j--
        }
        for i < j && arr[i] <= pivot {
            i++
        }
        if i < j {
            arr[i], arr[j] = arr[j], arr[i]
        }
    }
    arr[left], arr[i] = arr[i], arr[left]
    return i
}