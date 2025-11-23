import "math"

func maximumGroups(grades []int) int {
	n := len(grades)

	// We need to find the maximum k such that the sum of students for k groups
	// (1 + 2 + ... + k) is less than or equal to n.
	// The sum 1 + 2 + ... + k is k * (k + 1) / 2.
	// So, we need to find the maximum integer k such that k * (k + 1) / 2 <= n.
	// This inequality can be rewritten as k^2 + k - 2n <= 0.
	// To find the roots of k^2 + k - 2n = 0, we use the quadratic formula:
	// k = (-1 +/- sqrt(1 - 4 * 1 * (-2n))) / 2
	// k = (-1 +/- sqrt(1 + 8n)) / 2
	// Since k must be positive, we take the positive root:
	// k = (-1 + sqrt(1 + 8n)) / 2
	// The maximum integer k satisfying the inequality will be the floor of this value.

	discriminant := float64(1 + 8*n)
	kFloat := (-1.0 + math.Sqrt(discriminant)) / 2.0

	return int(kFloat)
}