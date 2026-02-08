func constructRectangle(area int) []int {
	for w := int(math.Sqrt(float64(area))); w >= 1; w-- {
		if area%w == 0 {
			return []int{area / w, w}
		}
	}
	return []int{}
}