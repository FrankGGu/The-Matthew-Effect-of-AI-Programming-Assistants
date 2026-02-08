package main

type Employee struct {
    Id       int
    Name     string
    ManagerId int
}

func hierarchicalPrint(employees []*Employee) []string {
    managerMap := make(map[int][]string)
    nameMap := make(map[int]string)
    for _, e := range employees {
        nameMap[e.Id] = e.Name
        if e.ManagerId != 0 {
            managerMap[e.ManagerId] = append(managerMap[e.ManagerId], e.Name)
        }
    }

    result := []string{}
    for id, names := range managerMap {
        result = append(result, nameMap[id])
        for _, name := range names {
            result = append(result, "  "+name)
        }
    }

    return result
}