func checkStrings(s1 string, s2 string) bool {
	// For s1 to be transformable into s2, two conditions must be met independently:
	// 1. The characters at even indices (s1[0], s1[2]) must be a permutation of (s2[0], s2[2]).
	// 2. The characters at odd indices (s1[1], s1[3]) must be a permutation of (s2[1], s2[3]).

	// Check even indices: s1[0], s1[2] vs s2[0], s2[2]
	// They are permutations if:
	// (s1[0] matches s2[0] AND s1[2] matches s2[2]) OR
	// (s1[0] matches s2[2] AND s1[2] matches s2[0])
	evenIndicesMatch := (s1[0] == s2[0] && s1[2] == s2[2]) || (s1[0] == s2[2] && s1[2] == s2[0])

	// Check odd indices: s1[1], s1[3] vs s2[1], s2[3]
	// They are permutations if:
	// (s1[1] matches s2[1] AND s1[3] matches s2[3]) OR
	// (s1[1] matches s2[3] AND s1[3] matches s2[1])
	oddIndicesMatch := (s1[1] == s2[1] && s1[3] == s2[3]) || (s1[1] == s2[3] && s1[3] == s2[1])

	// Both conditions must be true for s1 to be transformable into s2
	return evenIndicesMatch && oddIndicesMatch
}