type Book struct {
	BookID       int
	Name         string
	AvailableFrom time.Time
}

type Order struct {
	OrderID      int
	BookID