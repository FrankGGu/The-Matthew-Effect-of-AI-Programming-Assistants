func minNumberOfPeopleToTeach(language [][]int, socialGroups [][]int) int {
    taught := make(map[int]struct{})
    for _, group := range socialGroups {
        groupLanguages := make(map[int]struct{})
        for _, person := range group {
            for _, lang := range language[person-1] {
                groupLanguages[lang] = struct{}{}
            }
        }
        if len(groupLanguages) == 0 {
            continue
        }
        for _, person := range group {
            if len(language[person-1]) == 0 {
                taught[person] = struct{}{}
            } else {
                for _, lang := range language[person-1] {
                    if _, ok := groupLanguages[lang]; !ok {
                        taught[person] = struct{}{}
                        break
                    }
                }
            }
        }
    }
    return len(taught)
}