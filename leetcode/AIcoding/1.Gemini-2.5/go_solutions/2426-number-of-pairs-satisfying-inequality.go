func numberOfPairs(nums1 []int, nums2 []int, diff int) int {
	n := len(nums1)
	arr := make([]int, n)
	for k := 0; k < n; k++ {
		arr[k] = nums1[k] - nums2[k]
	}

	return mergeSortAndCount(arr, 0, n-1, diff)
}

func mergeSortAndCount(arr []int, low, high int, diff int) int {
	if low >= high {
		return 0
	}

	mid := low + (high-low)/2
	count := mergeSortAndCount(arr, low, mid, diff)
	count += mergeSortAndCount(arr, mid+1, high, diff)

	jPtr := mid + 1
	for i := low; i <= mid; i++ {
		for jPtr <= high && arr[jPtr] < arr[i]-diff {
			jPtr++
		}
		count += (high - jPtr + 1)
	}

	temp := make([]int, high-low+1)
	p1, p2, k := low, mid+1, 0
	for p1 <= mid && p2 <= high {
		if arr[p1] <= arr[p2] {
			temp[k] = arr[p1]
			p1++
		} else {
			temp[k] = arr[p2]
			p2++
		}
		k++
	}
	for p1 <= mid {
		temp[k] = arr[p1]
		p1++
		k++
	}
	for p2 <= high {
		temp[k] = arr[p2]
		p2++
		k++
	}
	for i := 0; i < len(temp); i++ {
		arr[low+i] = temp[i]
	}

	return count
}