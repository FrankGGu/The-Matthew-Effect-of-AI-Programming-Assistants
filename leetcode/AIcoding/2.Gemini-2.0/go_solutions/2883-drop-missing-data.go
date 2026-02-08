import (
	"fmt"
	"strconv"
)

type DataFrame struct {
	Data map[string][]interface{}
}

func DropMissingData(df DataFrame) DataFrame {
	validIndices := make(map[int]bool)
	for i := 0; i < len(df.Data[getFirstKey(df.Data)]); i++ {
		validIndices[i] = true
	}

	for _, column := range df.Data {
		for i, value := range column {
			if value == nil {
				delete(validIndices, i)
			}
		}
	}

	newDf := DataFrame{Data: make(map[string][]interface{})}
	for columnName, columnData := range df.Data {
		newDf.Data[columnName] = make([]interface{}, 0)
		for i := range columnData {
			if _, ok := validIndices[i]; ok {
				newDf.Data[columnName] = append(newDf.Data[columnName], columnData[i])
			}
		}
	}

	return newDf
}

func getFirstKey(m map[string][]interface{}) string {
	for k := range m {
		return k
	}
	return ""
}

func dataframeToString(df DataFrame) string {
	result := "{"
	for key, values := range df.Data {
		result += "\"" + key + "\":["
		for i, value := range values {
			if value == nil {
				result += "null"
			} else {
				switch v := value.(type) {
				case int:
					result += strconv.Itoa(v)
				case float64:
					result += fmt.Sprintf("%.1f", v)
				case string:
					result += "\"" + v + "\""
				default:
					result += fmt.Sprintf("%v", v)
				}
			}
			if i < len(values)-1 {
				result += ","
			}
		}
		result += "],"
	}
	result = result[:len(result)-1] + "}"
	return result
}