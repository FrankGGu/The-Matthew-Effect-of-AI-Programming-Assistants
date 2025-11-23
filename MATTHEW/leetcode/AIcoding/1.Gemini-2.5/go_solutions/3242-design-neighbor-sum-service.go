type NeighborSumService struct {
    data map[int]int
}

func Constructor() NeighborSumService {
    return NeighborSumService{
        data: make(map[int]int),
    }
}

func (s *NeighborSumService) Update(key int, value int) {
    s.data[key] = value
}

func (s *NeighborSumService) GetNeighborSum(key int) int {
    sum := 0
    if val, ok := s.data[key-1]; ok {
        sum += val
    }
    if val, ok := s.data[key+1]; ok {
        sum += val
    }
    return sum
}