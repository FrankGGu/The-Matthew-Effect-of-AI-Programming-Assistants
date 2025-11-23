type Node struct {
	Name      string
	Children  map[string]*Node
	IsDeleted bool
}

var structure