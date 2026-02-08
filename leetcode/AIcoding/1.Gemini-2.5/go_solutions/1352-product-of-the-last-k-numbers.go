type ProductOfNumbers struct {
	products []int
}

func Constructor() ProductOfNumbers {
	return ProductOfNumbers{
		products: []int{1},
	}
}

func (this *ProductOfNumbers) Add(num int) {
	if num == 0 {
		this.products = []int{1}
	} else {
		lastProduct := this.products[len(this.products)-1]
		this.products = append(this.products, lastProduct*num)
	}
}

func (this *ProductOfNumbers) GetProduct(k int) int {
	if k >= len(this.products) {
		return 0
	}
	return this.products[len(this.products)-1] / this.products[len(this.products)-1-k]
}