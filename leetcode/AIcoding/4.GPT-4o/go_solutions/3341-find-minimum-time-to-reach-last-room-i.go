type Item struct {
    room, time int
}

func minimumTime(rooms [][]int) int {
    n := len(rooms)
    dist := make([]int, n)
    for i := range dist {
        dist[i] = math.MaxInt64
    }
    dist[0] = 0
    pq := &[]Item{{0, 0}}
    heap.Init(pq)

    for len(*pq) > 0 {
        current := heap.Pop(pq).(Item)
        room, time := current.room, current.time

        if room == n-1 {
            return time
        }

        for nextRoom := room + 1; nextRoom < n; nextRoom++ {
            waitTime := (rooms[room][1] - time) % rooms[room][0]
            if waitTime < 0 {
                waitTime += rooms[room][0]
            }
            newTime := time + waitTime + rooms[nextRoom][0]
            if newTime < dist[nextRoom] {
                dist[nextRoom] = newTime
                heap.Push(pq, Item{nextRoom, newTime})
            }
        }
    }
    return -1
}