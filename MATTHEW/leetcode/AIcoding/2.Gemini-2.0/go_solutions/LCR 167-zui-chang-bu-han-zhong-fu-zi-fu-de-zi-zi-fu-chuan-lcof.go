func disassemblePlays(plays string) []string {
	result := []string{}
	for i := 0; i < len(plays); i++ {
		result = append(result, string(plays[i]))
	}
	return result
}