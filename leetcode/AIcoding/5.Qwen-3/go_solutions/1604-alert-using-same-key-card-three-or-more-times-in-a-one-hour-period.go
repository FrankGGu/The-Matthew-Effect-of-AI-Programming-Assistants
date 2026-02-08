package main

func alertNames(keyName []string, keyTime []string) []string {
    type entry struct {
        name  string
        time  int
    }
    var events []entry
    for i := 0; i < len(keyName); i++ {
        hour, _ := strconv.Atoi(keyTime[i][:2])
        minute, _ := strconv.Atoi(keyTime[i][3:])
        time := hour*60 + minute
        events = append(events, entry{name: keyName[i], time: time})
    }

    sort.Slice(events, func(i, j int) bool {
        if events[i].name != events[j].name {
            return events[i].name < events[j].name
        }
        return events[i].time < events[j].time
    })

    result := make(map[string]bool)
    for i := 0; i < len(events); i++ {
        if i+2 < len(events) && events[i].name == events[i+1].name && events[i].name == events[i+2].name {
            if events[i+2].time-events[i].time <= 59 {
                result[events[i].name] = true
            }
        }
    }

    var res []string
    for name := range result {
        res = append(res, name)
    }
    sort.Strings(res)
    return res
}