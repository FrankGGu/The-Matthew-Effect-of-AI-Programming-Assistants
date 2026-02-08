package main

type Person struct {
	name string
	age  int
}

func (p *Person) SetName(name string) *Person {
	p.name = name
	return p
}

func (p *Person) SetAge(age int) *Person {
	p.age = age
	return p
}

func (p *Person) GetName() string {
	return p.name
}

func (p *Person) GetAge() int {
	return p.age
}