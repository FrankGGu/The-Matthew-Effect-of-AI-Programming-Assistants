func closestDivisors(num int) []int {
    n1 := num + 1
    n2 := num + 2
    return findClosestDivisors(n1, n2)
}

func findClosestDivisors(n1, n2 int) []int {
    for i := int(math.Sqrt(float64(n1))); i >= 1; i-- {
        if n1%i == 0 {
            return []int{i, n1 / i}
        }
    }
    for i := int(math.Sqrt(float64(n2))); i >= 1; i-- {
        if n2%i == 0 {
            return []int{i, n2 / i}
        }
    }
    return nil
}