type Checkout struct {
    items []int
    total int
    discount map[int]int
}

func Constructor() Checkout {
    return Checkout{
        items: make([]int, 0),
        total: 0,
        discount: make(map[int]int),
    }
}

func (this *Checkout) Scan(item int) {
    this.items = append(this.items, item)
    this.total += item
    if cnt, exists := this.discount[item]; exists {
        if cnt > 1 {
            this.discount[item] = cnt - 1
        } else {
            delete(this.discount, item)
        }
    }
}

func (this *Checkout) Void(item int) {
    for i, val := range this.items {
        if val == item {
            this.items = append(this.items[:i], this.items[i+1:]...)
            this.total -= item
            return
        }
    }
}

func (this *Checkout) SetDiscount(item int, count int, discount int) {
    this.discount[item] = count
    for _, val := range this.items {
        if val == item && count > 0 {
            this.total -= discount
            count--
        }
    }
}

func (this *Checkout) GetTotal() int {
    return this.total
}