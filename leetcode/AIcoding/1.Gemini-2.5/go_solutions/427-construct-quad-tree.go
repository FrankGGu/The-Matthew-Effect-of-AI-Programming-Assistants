func construct(grid [][]int) *Node {
    n := len(grid)
    return build(grid, 0, 0, n)
}

func build(grid [][]int, row int, col int, size int) *Node {
    firstVal := grid[row][col]
    allSame := true
    for i := 0; i < size; i++ {
        for j := 0; j < size; j++ {
            if grid[row+i][col+j] != firstVal {
                allSame = false
                break
            }
        }
        if !allSame {
            break
        }
    }

    if allSame {
        return &Node{
            Val:    firstVal == 1,
            IsLeaf: true,
        }
    } else {
        halfSize := size / 2
        return &Node{
            Val:    true,
            IsLeaf: false,
            TopLeft:     build(grid, row, col, halfSize),
            TopRight:    build(grid, row, col+halfSize, halfSize),
            BottomLeft:  build(grid, row+halfSize, col, halfSize),
            BottomRight: build(grid, row+halfSize, col+halfSize, halfSize),
        }
    }
}