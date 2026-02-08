import (
	"strconv"
	"strings"
)

func solve(s string, k int) int {
	n := len(s)
	if n%k != 0 {
		return 0
	}

	count := 0
	subLen := n / k
	seen := make(map[string]bool)

	for i := 0; i < n; i += subLen {
		sub := s[i : i+subLen]
		if !seen[sub] {
			seen[sub] = true
			count++
		}
	}

	return count
}

func mostCommonWord(paragraph string, banned []string) string {
	bannedMap := make(map[string]bool)
	for _, word := range banned {
		bannedMap[word] = true
	}

	paragraph = strings.ToLower(paragraph)
	var sb strings.Builder
	wordCounts := make(map[string]int)

	for _, char := range paragraph {
		if (char >= 'a' && char <= 'z') || (char >= '0' && char <= '9') {
			sb.WriteRune(char)
		} else {
			word := sb.String()
			sb.Reset()
			if word != "" && !bannedMap[word] {
				wordCounts[word]++
			}
		}
	}

	// Handle the last word
	word := sb.String()
	if word != "" && !bannedMap[word] {
		wordCounts[word]++
	}

	maxCount := 0
	mostCommon := ""
	for word, count := range wordCounts {
		if count > maxCount {
			maxCount = count
			mostCommon = word
		}
	}

	return mostCommon
}

func findRestaurant(list1 []string, list2 []string) []string {
	indexMap := make(map[string]int)
	for i, restaurant := range list1 {
		indexMap[restaurant] = i
	}

	minSum := 2001
	var result []string

	for i, restaurant := range list2 {
		if index, ok := indexMap[restaurant]; ok {
			sum := i + index
			if sum < minSum {
				minSum = sum
				result = []string{restaurant}
			} else if sum == minSum {
				result = append(result, restaurant)
			}
		}
	}

	return result
}

func isHappy(n int) bool {
	seen := make(map[int]bool)
	for n != 1 && !seen[n] {
		seen[n] = true
		sum := 0
		for n > 0 {
			digit := n % 10
			sum += digit * digit
			n /= 10
		}
		n = sum
	}
	return n == 1
}

func groupAnagrams(strs []string) [][]string {
	anagramGroups := make(map[[26]int][]string)

	for _, str := range strs {
		var charCounts [26]int
		for _, char := range str {
			charCounts[char-'a']++
		}
		anagramGroups[charCounts] = append(anagramGroups[charCounts], str)
	}

	result := make([][]string, 0, len(anagramGroups))
	for _, group := range anagramGroups {
		result = append(result, group)
	}

	return result
}

func twoSum(nums []int, target int) []int {
	numMap := make(map[int]int)
	for i, num := range nums {
		complement := target - num
		if index, ok := numMap[complement]; ok {
			return []int{index, i}
		}
		numMap[num] = i
	}
	return []int{}
}

func isValidSudoku(board [][]byte) bool {
	// Check rows
	for i := 0; i < 9; i++ {
		seen := make(map[byte]bool)
		for j := 0; j < 9; j++ {
			if board[i][j] != '.' {
				if seen[board[i][j]] {
					return false
				}
				seen[board[i][j]] = true
			}
		}
	}

	// Check columns
	for j := 0; j < 9; j++ {
		seen := make(map[byte]bool)
		for i := 0; i < 9; i++ {
			if board[i][j] != '.' {
				if seen[board[i][j]] {
					return false
				}
				seen[board[i][j]] = true
			}
		}
	}

	// Check sub-boxes
	for boxRow := 0; boxRow < 3; boxRow++ {
		for boxCol := 0; boxCol < 3; boxCol++ {
			seen := make(map[byte]bool)
			for i := 0; i < 3; i++ {
				for j := 0; j < 3; j++ {
					row := boxRow*3 + i
					col := boxCol*3 + j
					if board[row][col] != '.' {
						if seen[board[row][col]] {
							return false
						}
						seen[board[row][col]] = true
					}
				}
			}
		}
	}

	return true
}

func firstUniqChar(s string) int {
	charCounts := make(map[rune]int)
	for _, char := range s {
		charCounts[char]++
	}

	for i, char := range s {
		if charCounts[char] == 1 {
			return i
		}
	}

	return -1
}

func intersection(nums1 []int, nums2 []int) []int {
	set1 := make(map[int]bool)
	for _, num := range nums1 {
		set1[num] = true
	}

	intersectionSet := make(map[int]bool)
	for _, num := range nums2 {
		if set1[num] {
			intersectionSet[num] = true
		}
	}

	result := make([]int, 0, len(intersectionSet))
	for num := range intersectionSet {
		result = append(result, num)
	}

	return result
}

func isIsomorphic(s string, t string) bool {
	if len(s) != len(t) {
		return false
	}

	sMap := make(map[byte]byte)
	tMap := make(map[byte]byte)

	for i := 0; i < len(s); i++ {
		sChar := s[i]
		tChar := t[i]

		sValue, sOk := sMap[sChar]
		tValue, tOk := tMap[tChar]

		if sOk && tOk {
			if sValue != tChar || tValue != sChar {
				return false
			}
		} else if !sOk && !tOk {
			sMap[sChar] = tChar
			tMap[tChar] = sChar
		} else {
			return false
		}
	}

	return true
}

func containsDuplicate(nums []int) bool {
	seen := make(map[int]bool)
	for _, num := range nums {
		if seen[num] {
			return true
		}
		seen[num] = true
	}
	return false
}

func singleNumber(nums []int) int {
	result := 0
	for _, num := range nums {
		result ^=