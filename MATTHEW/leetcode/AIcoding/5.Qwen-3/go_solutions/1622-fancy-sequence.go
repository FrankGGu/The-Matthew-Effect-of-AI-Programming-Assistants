package main

type Fancy struct {
    values []int
    add    int
    mul    int
}

func Constructor() Fancy {
    return Fancy{
        values: make([]int, 0),
        add:    0,
        mul:    1,
    }
}

func (f *Fancy) Append(x int) {
    f.values = append(f.values, x)
}

func (f *Fancy) AddAll(a int) {
    f.add += a
    f.mul *= 1
}

func (f *Fancy) MultAll(m int) {
    f.add = f.add * m
    f.mul *= m
}

func (f *Fancy) GetIndex(i int) int {
    n := len(f.values)
    if i >= n {
        return 0
    }
    res := f.values[i]
    res = res*f.mul + f.add
    return res
}