type Pair struct {
	val  int
	freq int
}

func rearrangeBarcodes(barcodes []int) []int {
	n := len(barcodes)
	if n <= 1 {
		return barcodes
	}