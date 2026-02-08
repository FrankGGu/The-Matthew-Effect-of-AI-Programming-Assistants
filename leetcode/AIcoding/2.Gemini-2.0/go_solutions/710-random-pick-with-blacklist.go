import "math/rand"

type Solution struct {
	size  int
	black map[int]int
}

func Constructor(n int, blacklist []int) Solution {
	blackMap := make(map[int]int)
	for _, b := range blacklist {
		blackMap[b] = -1
	}

	size := n - len(blacklist)
	s := Solution{size: size, black: blackMap}

	for b := range s.black {
		if b < size {
			for n-1 >= size && s.black[n-1] == -1 {
				n--
			}

			if n-1 >= size {
				s.black[b] = n - 1
				n--
			}
		}
	}

	return s
}

func (s *Solution) Pick() int {
	index := rand.Intn(s.size)
	if val, ok := s.black[index]; ok {
		return val
	}
	return index
}