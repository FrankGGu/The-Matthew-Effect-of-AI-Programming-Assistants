func waysToBuyPensPencils(total int, cost1 int, cost2 int) int64 {
	ans := 0
	for i := 0; i*cost1 <= total; i++ {
		remaining := total - i*cost1
		ans += remaining/cost2 + 1
	}
	return int64(ans)
}