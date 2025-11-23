type Fraction struct {
	num int
	den int
}

type Fractions []Fraction

func (f Fractions) Len() int {
	return len(f)