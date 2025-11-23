import "fmt"

func solve() {
	var n int
	fmt.Scan(&n)
	a := make([][]int, n)
	for i := range a {
		a[i] = make([]int, n)
		for j := range a[i] {
			fmt.Scan(&a[i][j])
		}
	}

	ans := 0
	for i := 0; i < n-1; i++ {
		for j := 0; j < n-1; j++ {
			cnt0 := 0
			cnt1 := 0
			if a[i][j] == 0 {
				cnt0++
			} else {
				cnt1++
			}
			if a[i+1][j] == 0 {
				cnt0++
			} else {
				cnt1++
			}
			if a[i][j+1] == 0 {
				cnt0++
			} else {
				cnt1++
			}
			if a[i+1][j+1] == 0 {
				cnt0++
			} else {
				cnt1++
			}
			if cnt0 == 1 || cnt0 == 3 {
				ans++
			}
		}
	}

	fmt.Println(ans)
}