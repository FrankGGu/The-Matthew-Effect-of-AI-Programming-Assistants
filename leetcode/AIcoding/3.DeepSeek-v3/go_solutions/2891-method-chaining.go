type Animal struct {
    name string
    age  int
}

func (a *Animal) SetName(name string) *Animal {
    a.name = name
    return a
}

func (a *Animal) SetAge(age int) *Animal {
    a.age = age
    return a
}

func (a *Animal) GetName() string {
    return a.name
}

func (a *Animal) GetAge() int {
    return a.age
}