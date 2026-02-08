type Task struct {
	Start int
	End   int
	Cost  int
}

type ByEndTime []Task

func (a ByEndTime