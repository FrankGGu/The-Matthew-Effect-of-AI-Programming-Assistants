type ProductOfNumbers struct {
    prefixProducts []int
}

func Constructor() ProductOfNumbers {
    return ProductOfNumbers{prefixProducts: []int{1}}
}

func (this *ProductOfNumbers) Add(num int)  {
    if num == 0 {
        this.prefixProducts = []int{1}
    } else {
        this.prefixProducts = append(this.prefixProducts, this.prefixProducts[len(this.prefixProducts)-1] * num)
    }
}

func (this *ProductOfNumbers) GetProduct(k int) int {
    if k >= len(this.prefixProducts) {
        return 0
    }
    return this.prefixProducts[len(this.prefixProducts)-1] / this.prefixProducts[len(this.prefixProducts)-1-k]
}