func minimumMoney(transactions [][]int) int64 {
	var totalLoss int64 = 0
	var maxRefundForLossy int64 = 0 // max refund from a lossy transaction that is done last
	var maxCost