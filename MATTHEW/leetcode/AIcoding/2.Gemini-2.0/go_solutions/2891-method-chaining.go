type Calculator struct {
	val int
}

func NewCalculator() Calculator {
	return Calculator{val: 0}
}

func (this *Calculator) Add(value int) Calculator {
	this.val += value
	return *this
}

func (this *Calculator) Subtract(value int) Calculator {
	this.val -= value
	return *this
}

func (this *Calculator) Multiply(value int) Calculator {
	this.val *= value
	return *this
}

func (this *Calculator) Divide(value int) Calculator {
	if value == 0 {
		this.val = 0
		return *this
	}
	this.val /= value
	return *this
}

func (this *Calculator) GetValue() int {
	return this.val
}