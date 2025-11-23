package main

func countRangeSum(nums []int, lower int, upper int) int {
	type pair struct {
		sum  int
		idx  int
	}
	var mergeSort func([]pair, int, int) int
	mergeSort = func(arr []pair, left, right int) int {
		if left >= right {
			return 0
		}
		mid := left + (right-left)/2
		count := mergeSort(arr, left, mid) + mergeSort(arr, mid+1, right)
		j, k := mid+1, mid+1
		for i := left; i <= mid; i++ {
			for j <= right && arr[j].sum < arr[i].sum-lower {
				j++
			}
			for k <= right && arr[k].sum <= arr[i].sum-upper {
				k++
			}
			count += (k - j)
		}
		temp := make([]pair, 0, right-left+1)
		i, l := left, mid+1
		for i <= mid && l <= right {
			if arr[i].sum <= arr[l].sum {
				temp = append(temp, arr[i])
				i++
			} else {
				temp = append(temp, arr[l])
				l++
			}
		}
		for i <= mid {
			temp = append(temp, arr[i])
			i++
		}
		for l <= right {
			temp = append(temp, arr[l])
			l++
		}
		copy(arr[left:right+1], temp)
		return count
	}
	sums := make([]pair, len(nums)+1)
	for i := range nums {
		sums[i+1].sum = sums[i].sum + nums[i]
		sums[i+1].idx = i + 1
	}
	return mergeSort(sums, 0, len(sums)-1)
}