package main


type NestedInteger struct {
	// Use the functions below to access the data
}

func (n NestedInteger) IsInteger() bool {
	return false
}

func (n NestedInteger) GetInteger() int {
	return 0
}

func (n *NestedInteger) SetInteger(value int) {}

func (n *NestedInteger) SetList(value []*NestedInteger) {}

func (n NestedInteger) GetList() []*NestedInteger {
	return nil
}

func deserialize(s string) *NestedInteger {
	if len(s) == 0 {
		return &NestedInteger{}
	}
	if s[0] != '[' {
		num, _ := strconv.Atoi(s)
		result := &NestedInteger{}
		result.SetInteger(num)
		return result
	}
	result := &NestedInteger{}
	i := 1
	for i < len(s)-1 {
		if s[i] == ',' {
			i++
		} else if s[i] == '[' {
			j := i
			count := 1
			for j < len(s)-1 && count > 0 {
				j++
				if s[j] == '[' {
					count++
				} else if s[j] == ']' {
					count--
				}
			}
			sub := deserialize(s[i:j+1])
			result.GetList() = append(result.GetList(), sub)
			i = j + 1
		} else {
			j := i
			for j < len(s)-1 && s[j+1] != ',' && s[j+1] != ']' {
				j++
			}
			num, _ := strconv.Atoi(s[i:j+1])
			sub := &NestedInteger{}
			sub.SetInteger(num)
			result.GetList() = append(result.GetList(), sub)
			i = j + 1
		}
	}
	return result
}