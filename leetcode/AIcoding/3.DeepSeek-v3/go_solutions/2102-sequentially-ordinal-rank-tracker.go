type SORTracker struct {
    locations []location
    queryCount int
}

type location struct {
    name string
    score int
}

func Constructor() SORTracker {
    return SORTracker{
        locations: make([]location, 0),
        queryCount: 0,
    }
}

func (this *SORTracker) Add(name string, score int) {
    loc := location{name: name, score: score}
    idx := sort.Search(len(this.locations), func(i int) bool {
        if this.locations[i].score == loc.score {
            return this.locations[i].name > loc.name
        }
        return this.locations[i].score < loc.score
    })
    this.locations = append(this.locations[:idx], append([]location{loc}, this.locations[idx:]...)...)
}

func (this *SORTracker) Get() string {
    res := this.locations[len(this.locations)-1-this.queryCount].name
    this.queryCount++
    return res
}