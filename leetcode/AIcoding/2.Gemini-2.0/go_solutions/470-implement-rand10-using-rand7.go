import "math/rand"

func rand7() int {
	return rand.Intn(7) + 1
}

func rand10() int {
	for {
		val := (rand7()-1)*7 + (rand7()-1)
		if val < 40 {
			return val%10 + 1
		}
	}
}