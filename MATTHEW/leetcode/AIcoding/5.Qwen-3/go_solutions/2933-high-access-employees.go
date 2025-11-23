package main

func highAccessEmployees(employees []string) []string {
    accessMap := make(map[string][]int)
    for _, emp := range employees {
        name := emp[:3]
        time := int(emp[4] - '0')*10 + int(emp[5] - '0')
        accessMap[name] = append(accessMap[name], time)
    }

    result := []string{}
    for name, times := range accessMap {
        if len(times) < 3 {
            continue
        }
        sort.Ints(times)
        for i := 0; i <= len(times)-3; i++ {
            if times[i+2]-times[i] < 100 {
                result = append(result, name)
                break
            }
        }
    }
    return result
}