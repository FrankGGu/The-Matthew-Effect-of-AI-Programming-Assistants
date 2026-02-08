type Calculator struct {
	result int
}

func Constructor() *Calculator {
	return &Calculator{result: 0}
}

func (c *Calculator) Add(value int) *Calculator {
	c.result += value
	return c
}

func (c *Calculator) Subtract(value int) *Calculator {
	c.result -= value
	return c
}

func (c *Calculator) Multiply(value int) *Calculator {
	c.result *= value
	return c
}

func (c *Calculator) Divide(value int) *Calculator {
	if value != 0 {
		c.result /= value
	}
	return c
}

func (c *Calculator) GetResult() int {
	return c.result
}