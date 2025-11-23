type UnionFind struct {
    parent []int
    size   []int
}

func NewUnionFind(n int) *UnionFind {
    parent := make([]int, n)
    size := make([]int, n)
    for i := range parent {
        parent[i] = i
        size[i] = 1
    }
    return &UnionFind{parent, size}
}

func (uf *UnionFind) Find(x int) int {
    if uf.parent[x] != x {
        uf.parent[x] = uf.Find(uf.parent[x])
    }
    return uf.parent[x]
}

func (uf *UnionFind) Union(x, y int) {
    rootX := uf.Find(x)
    rootY := uf.Find(y)
    if rootX != rootY {
        if uf.size[rootX] < uf.size[rootY] {
            rootX, rootY = rootY, rootX
        }
        uf.parent[rootY] = rootX
        uf.size[rootX] += uf.size[rootY]
    }
}

func largestComponentSize(nums []int) int {
    maxNum := 0
    for _, num := range nums {
        if num > maxNum {
            maxNum = num
        }
    }

    uf := NewUnionFind(maxNum + 1)
    for _, num := range nums {
        for i := 2; i*i <= num; i++ {
            if num%i == 0 {
                uf.Union(num, i)
                uf.Union(num, num/i)
            }
        }
    }

    count := make(map[int]int)
    maxSize := 0
    for _, num := range nums {
        root := uf.Find(num)
        count[root]++
        if count[root] > maxSize {
            maxSize = count[root]
        }
    }

    return maxSize
}